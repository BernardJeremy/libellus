import { createAction, handleActions } from 'redux-actions'
import _ from 'lodash'

export const CLASSES_LOAD = 'CLASSES_LOAD'
export const CLASSES_LOADED = 'CLASSES_LOADED'
export const CLASSES_LOAD_FAIL = 'CLASSES_LOAD_FAIL'
export const CLASSES_SELECT_ID = 'CLASSES_SELECT_ID'
export const CLASSES_ADD_TO_LIST = 'CLASSES_ADD_TO_LIST'
export const CLASSES_REMOVE_FROM_LIST = 'CLASSES_REMOVE_FROM_LIST'

export const load = createAction(CLASSES_LOAD, ({subjectId, termId}) => {
  return {
    types: [CLASSES_LOAD, CLASSES_LOADED, CLASSES_LOAD_FAIL],
    promise: (client) => client.get('/subjects/' + subjectId + '/classes', {params: {term: termId}})
  }
})

export const selectClassId = createAction(CLASSES_SELECT_ID, (id) => id)

export const addToList = createAction(CLASSES_ADD_TO_LIST, (id) => id)
export const removeFromList = createAction(CLASSES_REMOVE_FROM_LIST, (id) => id)

export default handleActions({
  [CLASSES_LOAD]: (state) => { return {...state, loading: true, failure: false, content: [], raw: [], startClassMinutes: 0, endClassMinutes: 60 * 24} },
  [CLASSES_LOADED]: (state, { result }) => {
    const classes = _.chain(result).map((currentClass) => {
      return _.map(currentClass.time, (time) => {
        const classTime = _.clone(currentClass)
        classTime.otherTimes = _.without(currentClass.time, time)
        classTime.time = time
        classTime.time.startMinute = Number(time.start.split(':')[0]) * 60 + Number(time.start.split(':')[1])
        classTime.time.endMinute = Number(time.end.split(':')[0]) * 60 + Number(time.end.split(':')[1])
        classTime.time.duration = classTime.time.endMinute - classTime.time.startMinute
        return classTime
      })
    }).flatten().value()
    const startClassMinutes = _.chain(classes).map('time.startMinute').min().value()
    const endClassMinutes = _.chain(classes).map('time.endMinute').max().value()
    return {...state, loading: false, failure: false, content: classes, raw: result, startClassMinutes, endClassMinutes}
  },
  [CLASSES_LOAD_FAIL]: (state, { payload }) => {
    return {...state, loading: false, failure: true, content: [], raw: [], startClassMinutes: 0, endClassMinutes: 60 * 24}
  },
  [CLASSES_SELECT_ID]: (state, {payload}) => {
    return {...state, selectedClassId: payload}
  },
  [CLASSES_ADD_TO_LIST]: (state, {payload}) => {
    return {...state, selectedClassId: payload, registeredClasses: _.union(state.registeredClasses, [payload])}
  },
  [CLASSES_REMOVE_FROM_LIST]: (state, {payload}) => {
    return {...state, selectedClassId: payload, registeredClasses: _.without(state.registeredClasses, payload)}
  }
}, {loading: false, failure: false, content: [], raw: [], selectedClassId: null, registeredClasses: [], startClassMinutes: 0, endClassMinutes: 60 * 24})
