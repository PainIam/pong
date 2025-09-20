#pragma once
#include <SFML/Graphics.hpp>

class Bat {
private:
    float m_Speed = 500.0f;
    bool m_MoveRight = false;
    bool m_MoveLeft = false;
    sf::RectangleShape m_Shape;
    sf::Vector2f m_Position;
public:
    Bat(float startX, float startY);
    sf::FloatRect getPosition();
    sf::RectangleShape& getShape();
    void moveRight();
    void moveLeft();
    void stopRight();
    void stopLeft();
    void update(sf::Time dt);
};
