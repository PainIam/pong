#pragma once
#include <SFML/Graphics.hpp>

class Bat {
private:
    float m_Speed = 500.0f;a
    float m_DirX;
    float m_DirY;
    bool m_MoveRight = false;
    bool m_MoveLeft = false;
    sf::RectangleShape m_Shape;
    sf::FloatRect m_Position;
public:
    Bat(float startX, float startY);
    void getPosition();
    void getShape();
    void moveRight();
    void moveLeft();
    void stopRight();
    void stopLetf();
    void update(sf::Time dt);
};
