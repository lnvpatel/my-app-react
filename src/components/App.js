import React, { Component, Fragment } from 'react';
import Header from './Header';
import RestaurantsDisplay from './RestaurantsDisplay';
import './App.css'; // Import the CSS file from components

const url = "http://43.205.94.30:8443/restaurant/";

class App extends Component {
  constructor() {
    super();
    this.state = {
      restaurants: []
    };
  }

  componentDidMount() {
    fetch(url, {
      method: 'GET'
    })
      .then((res) => res.json())
      .then((data) => {
        this.setState({
          restaurants: data
        });
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
      });
  }

  render() {
    return (
      <Fragment>
        <Header />
        <RestaurantsDisplay datalist={this.state.restaurants} />
      </Fragment>
    );
  }
}

export default App;