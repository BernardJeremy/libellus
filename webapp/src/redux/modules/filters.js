import { createAction, handleActions } from 'redux-actions'

export const CHANGE_TERM_FILTER = 'CHANGE_TERM_FILTER'
export const CHANGE_SUBJECT_FILTER = 'CHANGE_SUBJECT_FILTER'

export const changeTerm = createAction(CHANGE_TERM_FILTER, (termId) => termId)
export const changeSubject = createAction(CHANGE_SUBJECT_FILTER, (subjectId) => subjectId)

export default handleActions({
  [CHANGE_TERM_FILTER]: (state, { payload }) => { return {...state, termId: payload} },
  [CHANGE_SUBJECT_FILTER]: (state, { payload }) => { return {...state, subjectId: payload} }
}, {termId: null, subjectId: null})
