import { createAction, handleActions } from 'redux-actions'
import _ from 'lodash'

export const CLASSES_LOAD = 'CLASSES_LOAD'
export const CLASSES_LOADED = 'CLASSES_LOADED'
export const CLASSES_LOAD_FAIL = 'CLASSES_LOAD_FAIL'
export const CLASSES_SELECT_ID = 'CLASSES_SELECT_ID'

export const load = createAction(CLASSES_LOAD, ({subjectId, termId}) => {
  return {
    types: [CLASSES_LOAD, CLASSES_LOADED, CLASSES_LOAD_FAIL],
    promise: (client) => client.get('/subjects/' + subjectId + '/classes', {params: {term: termId}})
  }
})

export const selectClassId = createAction(CLASSES_SELECT_ID, (id) => id)

export const actions = {
  load,
  selectClassId
}

export default handleActions({
  [CLASSES_LOAD]: (state) => { return {...state, loading: true, failure: false, content: []} },
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
    return {...state, loading: false, failure: false, content: classes}
  },
  [CLASSES_LOAD_FAIL]: (state, { payload }) => {
    return {...state, loading: false, failure: true, content: []}
  },
  [CLASSES_SELECT_ID]: (state, {payload}) => {
    return {...state, selectedClassId: payload}
  }
}, {loading: false, failure: false, content: [], selectedClassId: null})
