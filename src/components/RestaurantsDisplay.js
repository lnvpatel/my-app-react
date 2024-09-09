import React from 'react';
import RestaurantCard from './RestaurantCard';
import './RestaurantsDisplay.css'; // If you have specific styles for RestaurantsDisplay

const RestaurantsDisplay = ({ datalist }) => {
  return (
    <div className="restaurants-display">
      {datalist.length > 0 ? (
        datalist.map((restaurant) => (
          <RestaurantCard key={restaurant.id} restaurant={restaurant} />
        ))
      ) : (
        <p>No restaurants found.</p>
      )}
    </div>
  );
};

export default RestaurantsDisplay;