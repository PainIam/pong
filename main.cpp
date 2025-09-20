#include "Bat.hpp"
#include <SFML/Graphics.hpp>

int main() {
    const int WIDTH = 1366;
    const int HEIGHT = 769;
    sf::VideoMode vm(WIDTH, HEIGHT);
    sf::RenderWindow window(vm, "Pong", sf::Style::Default);

    Bat bat(WIDTH / 2 - 100, HEIGHT-90);
    sf::Clock clock;
    while(window.isOpen()) {
        
        sf::Event event;
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed)
                window.close();
        }
        
        sf::Time dt = clock.restart();
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right)) {
            bat.moveRight();
            bat.update(dt);
        }


        window.clear();
        window.draw(bat.getShape());
        window.display();
    }
}
