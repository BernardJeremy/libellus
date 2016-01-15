import { combineReducers } from 'redux'
import { routeReducer as router } from 'redux-simple-router'
import filters from './modules/filters'
import terms from './modules/terms'
import subjects from './modules/subjects'
import classes from './modules/classes'
import scheduleStyle from './modules/scheduleStyle'

export default combineReducers({
  filters,
  terms,
  subjects,
  classes,
  scheduleStyle,
  router
})
