import { createAction, handleActions } from 'redux-actions'

export const CHANGE_SCHEDULE_HEIGHT = 'CHANGE_SCHEDULE_HEIGHT'

export const changeScheduleHeight = createAction(CHANGE_SCHEDULE_HEIGHT, (height) => height)

export default handleActions({
  [CHANGE_SCHEDULE_HEIGHT]: (state, { payload }) => { return {...state, height: payload} }
}, {height: 50})
