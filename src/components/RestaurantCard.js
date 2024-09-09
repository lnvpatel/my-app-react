import React from 'react';
import './RestaurantCard.css'; // If you have specific styles for RestaurantCard

const RestaurantCard = ({ restaurant }) => {
  return (
    <div className="restaurant-card">
      <h2>{restaurant.name}</h2>
      <p>{restaurant.cuisine}</p>
      <p>{restaurant.address}</p>
    </div>
  );
};

export default RestaurantCard;