import React from 'react';
import ReactDOM from 'react-dom/client';
import { Provider } from 'react-redux';
import './index.css';
import App from './App';
import Auth from './helpers/Auth';

import configureStore from './redux/store';
const store = configureStore();

const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
  <Provider store={store}>
    <Auth>
      <App />
    </Auth>
  </Provider>
);

