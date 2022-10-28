import {
    createStore,
    combineReducers,
    compose,
    applyMiddleware,
  } from 'redux';
  
  import ReduxThunk from 'redux-thunk'
  
  import userSlice from './userSlice';
  
  // if you're also using redux-thunk, add it as a middleware
  const createStoreWithMiddleware = compose(applyMiddleware(ReduxThunk))(createStore);
  
  const rootReducer = combineReducers({
    user: userSlice,
  });
  
  export default function configureStore(initialState = {}) {
    return createStoreWithMiddleware(rootReducer, initialState);
  };
  