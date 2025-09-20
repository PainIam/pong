#include "Bat.hpp"

Bat::Bat(float startX, float startY)
    : m_Position(startX, startY) {
        m_Shape.setSize(sf::Vector2f(200, 20));
        m_Shape.setPosition(m_Position);
        m_Shape.setFillColor(sf::Color::White);
  
    }
sf::FloatRect Bat::getPosition() {
    return m_Shape.getGlobalBounds();
}

sf::RectangleShape& Bat::getShape() {
    return m_Shape;
}

void Bat::moveRight() {
    m_MoveRight = true;
}

void Bat::stopRight() {
    m_MoveRight = false;
}

void Bat::moveLeft() {
    m_MoveLeft = true;
}

void Bat::stopLeft() {
    m_MoveLeft = false;
}

void Bat::update(sf::Time dt) {
    if (m_MoveRight) {
        m_Position.x += m_Speed * dt.asSeconds();
    } 
    if (m_MoveLeft) {
        m_Position.x -= m_Speed * dt.asSeconds();
    }
    m_Shape.setPosition(m_Position);
}




