pip install pygame


# Initialize Pygame
pygame.init()

# Screen dimensions
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Car Racing Game")

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
GRAY = (169, 169, 169)

# Game Clock
clock = pygame.time.Clock()

# Car properties
CAR_WIDTH = 50
CAR_HEIGHT = 100

# Load car image
player_car = pygame.image.load("car.png")  # Replace with your car image file path
player_car = pygame.transform.scale(player_car, (CAR_WIDTH, CAR_HEIGHT))

# Enemy car
enemy_car = pygame.image.load("enemy_car.png")  # Replace with your enemy car image file path
enemy_car = pygame.transform.scale(enemy_car, (CAR_WIDTH, CAR_HEIGHT))

# Function to display text
def display_text(message, font_size, color, x, y):
    font = pygame.font.Font(None, font_size)
    text = font.render(message, True, color)
    screen.blit(text, (x, y))

# Main game loop
def game_loop():
    # Initial settings
    player_x = SCREEN_WIDTH // 2 - CAR_WIDTH // 2
    player_y = SCREEN_HEIGHT - CAR_HEIGHT - 10
    player_speed = 10

    enemy_x = random.randint(50, SCREEN_WIDTH - CAR_WIDTH - 50)
    enemy_y = -CAR_HEIGHT
    enemy_speed = 7

    score = 0
    running = True
    game_over = False

    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        # Key press handling
        keys = pygame.key.get_pressed()
        if keys[pygame.K_LEFT] and player_x > 50:
            player_x -= player_speed
        if keys[pygame.K_RIGHT] and player_x < SCREEN_WIDTH - CAR_WIDTH - 50:
            player_x += player_speed

        # Update enemy position
        enemy_y += enemy_speed
        if enemy_y > SCREEN_HEIGHT:
            enemy_y = -CAR_HEIGHT
            enemy_x = random.randint(50, SCREEN_WIDTH - CAR_WIDTH - 50)
            score += 1
            enemy_speed += 0.2  # Gradually increase difficulty

        # Collision detection
        if (player_x < enemy_x + CAR_WIDTH and
                player_x + CAR_WIDTH > enemy_x and
                player_y < enemy_y + CAR_HEIGHT and
                player_y + CAR_HEIGHT > enemy_y):
            game_over = True

        # Drawing the screen
        screen.fill(GRAY)
        pygame.draw.rect(screen, WHITE, (50, 0, SCREEN_WIDTH - 100, SCREEN_HEIGHT))

        # Draw player car
        screen.blit(player_car, (player_x, player_y))

        # Draw enemy car
        screen.blit(enemy_car, (enemy_x, enemy_y))

        # Display score
        display_text(f"Score: {score}", 36, BLACK, 60, 20)

        if game_over:
            display_text("GAME OVER!", 72, RED, SCREEN_WIDTH // 2 - 200, SCREEN_HEIGHT // 2 - 50)
            display_text("Press R to Restart or Q to Quit", 36, BLACK, SCREEN_WIDTH // 2 - 200, SCREEN_HEIGHT // 2 + 50)
            pygame.display.update()
            while game_over:
                for event in pygame.event.get():
                    if event.type == pygame.QUIT:
                        running = False
                        game_over = False
                    if event.type == pygame.KEYDOWN:
                        if event.key == pygame.K_r:  # Restart the game
                            game_loop()
                        if event.key == pygame.K_q:  # Quit the game
                            running = False
                            game_over = False

        pygame.display.update()
        clock.tick(60)

    pygame.quit()

# Start the game
game_loop()
