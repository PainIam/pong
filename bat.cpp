#include "Bat.hpp"

Bat::Bat(float StartX, float StartY)
    : m_DirX(startX), m_DirY(startY) {
        m_Position(m_DirX, m_DirY);
        m_Shape.setSize(sf::Vector2f(50, 10));
        m_Shape.setPosition(m_Position);
        m_Shape.setFillColor(sf::Color::White);
  
    }
Bat::getPosition() {
    return m_Shape.getPosition;
}

Bat::getShape() {
    return m_Shape;
}

void moveRight() {
    m_MoveRight = true
}

void stopRight() {
    m_MoveRight = false;
}

void moveLeft() {
    m_MoveLeft = true;
}

void stopLeft() {
    m_MoveLeft = false;
}

void update(sf::Time dt) {
    if (m_MoveRight) {
        m_DirX += m_Speed * dt.asSeconds();
    } else {
        m_DirY -= m_SPeed * dt.asSeconds();
    }

    m_Shape.setPosition(m_DirX, m_DirY);
}




