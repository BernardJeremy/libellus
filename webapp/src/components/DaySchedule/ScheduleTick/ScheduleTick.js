import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import classes from './ScheduleTick.scss'
import ClassSchedule from '../ClassSchedule/ClassSchedule'
import SelectedClassWrapper from './SelectedClassWrapper'
import _ from 'lodash'

const reducedDaysName = [ 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' ]
const hours = [ '1:00am', '2:00am', '3:00am', '4:00am', '5:00am', '6:00am', '7:00am', '8:00am', '9:00am', '10:00am', '11:00am', '12:00am', '1:00pm', '2:00pm', '3:00pm', '4:00pm', '5:00pm', '6:00pm', '7:00pm', '8:00pm', '9:00pm', '10:00pm', '11:00pm', '12:00pm' ]

const mapStateToProps = (state, props) => {
  const classesInTick = _.filter(state.classes.content, (currentClass) => currentClass.time.day === reducedDaysName[props.day] && Number(currentClass.time.start.split(':')[0]) === props.hour)
  const hasPendingClasses = _.any(state.classes.content, (currentClass) => {
    return currentClass.time.day === reducedDaysName[props.day] &&
      Number(currentClass.time.start.split(':')[0]) < props.hour &&
      Number(currentClass.time.end.split(':')[0]) >= props.hour
  })
  return {
    height: state.scheduleStyle.height,
    classesInTick,
    hasPendingClasses,
    showConflictedCourses: state.filters.showConflictedCourses,
    registeredClasses: state.classes.registeredClasses.map((id) => _.find(state.classes.raw, {id})),
    showNonRegisteredClasses: state.filters.showNonRegisteredClasses
  }
}
export class DaySchedule extends React.Component {
  static propTypes = {
    height: PropTypes.number.isRequired,
    hour: PropTypes.number.isRequired,
    day: PropTypes.number.isRequired,
    classesInTick: PropTypes.arrayOf(PropTypes.object),
    registeredClasses: PropTypes.arrayOf(PropTypes.object),
    hasPendingClasses: PropTypes.bool,
    showConflictedCourses: PropTypes.bool,
    showNonRegisteredClasses: PropTypes.bool
  };

  render () {
    const classesToRender = _.filter(this.props.classesInTick, (currentClass) => {
      const registered = _.any(this.props.registeredClasses, {id: currentClass.id})
      if (!registered && !this.props.showNonRegisteredClasses) { return false }
      if (registered) { return true }
      if (this.props.showConflictedCourses) { return true }
      if (_.chain(this.props.registeredClasses).map('time').flatten().any((time) =>
        time.day === currentClass.time.day &&
        time.startMinute < currentClass.time.endMinute &&
        time.endMinute > currentClass.time.startMinute
      ).value()) { return false }
      return true
    })

    const classesEls = classesToRender.map((currentClass, i) => {
      const style = {
        width: (100 / classesToRender.length) + '%',
        left: ((100 / classesToRender.length) * i) + '%',
        zIndex: 10 + this.props.hour
      }
      if (this.props.hasPendingClasses) {
        style.marginLeft = 5
      }
      return (
        <div className={classes['class-container']} style={style} key={currentClass.id}>
          <SelectedClassWrapper data={currentClass}>
            <ClassSchedule data={currentClass}/>
          </SelectedClassWrapper>
        </div>
      )
    })

    const tickStyle = {
      height: this.props.height + 'px'
    }

    return (
      <div className={classes['tick']} style={tickStyle}>
        <p>{hours[this.props.hour]}</p>
        <div className={classes['classes']}>
          {classesEls}
        </div>
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(DaySchedule)
