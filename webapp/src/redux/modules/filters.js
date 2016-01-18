import { createAction, handleActions } from 'redux-actions'
import _ from 'lodash'

export const CHANGE_TERM_FILTER = 'CHANGE_TERM_FILTER'
export const CHANGE_SUBJECT_FILTER = 'CHANGE_SUBJECT_FILTER'
export const CHANGE_CONFLICTED_COURSE_VISIBILITY = 'CHANGE_CONFLICTED_COURSE_VISIBILITY'
export const CHANGE_NON_REGISTERED_CLASS_VISIBILITY = 'CHANGE_NON_REGISTERED_CLASS_VISIBILITY'
export const CHANGE_LEVEL_VISIBILITY = 'CHANGE_LEVEL_VISIBILITY'

export const changeTerm = createAction(CHANGE_TERM_FILTER, (termId) => termId)
export const changeSubject = createAction(CHANGE_SUBJECT_FILTER, (subjectId) => subjectId)
export const changeConflictedCourseVisibility = createAction(CHANGE_CONFLICTED_COURSE_VISIBILITY, (showCourses) => showCourses)
export const changeNonRegisteredClassVisibility = createAction(CHANGE_NON_REGISTERED_CLASS_VISIBILITY, (showCourses) => showCourses)
export const changeLevelVisibility = createAction(CHANGE_LEVEL_VISIBILITY, (level, showCourses) => ({ level, showCourses }))

export default handleActions({
  [CHANGE_TERM_FILTER]: (state, { payload }) => { return {...state, termId: payload} },
  [CHANGE_SUBJECT_FILTER]: (state, { payload }) => { return {...state, subjectId: payload} },
  [CHANGE_CONFLICTED_COURSE_VISIBILITY]: (state, { payload }) => { return {...state, showConflictedCourses: payload} },
  [CHANGE_NON_REGISTERED_CLASS_VISIBILITY]: (state, { payload }) => { return {...state, showNonRegisteredClasses: payload} },
  [CHANGE_LEVEL_VISIBILITY]: (state, { payload }) => {
    let newLevels = _.clone(state.levels) || _.times(6, true)
    newLevels[payload.level] = Boolean(payload.showCourses)
    return {...state, levels: newLevels}
  }
}, {termId: null, subjectId: null, showConflictedCourses: true, showNonRegisteredClasses: true, levels: _.times(6, () => true)})
