import thunk from 'redux-thunk'
import rootReducer from './rootReducer'
import clientMiddleware from './middlewares/clientMiddleware'
import {
  applyMiddleware,
  compose,
  createStore
} from 'redux'
import persistState from 'redux-localstorage'

export default function configureStore (initialState) {
  let createStoreWithMiddleware
  const middleware = applyMiddleware(thunk, clientMiddleware)

  if (__DEBUG__) {
    createStoreWithMiddleware = compose(
      persistState(null, {key: 'libellus'}),
      middleware,
      window.devToolsExtension
        ? window.devToolsExtension()
        : require('containers/DevTools').default.instrument()
    )
  } else {
    createStoreWithMiddleware = compose(persistState(null, {key: 'libellus'}), middleware)
  }

  const store = createStoreWithMiddleware(createStore)(
    rootReducer, initialState
  )
  if (module.hot) {
    module.hot.accept('./rootReducer', () => {
      const nextRootReducer = require('./rootReducer').default

      store.replaceReducer(nextRootReducer)
    })
  }
  return store
}
