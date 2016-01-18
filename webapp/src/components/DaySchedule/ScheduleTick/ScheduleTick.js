import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import classes from './ScheduleTick.scss'
import classScheduleClasses from '../ClassSchedule/ClassSchedule.scss'
import ClassSchedule from '../ClassSchedule/ClassSchedule'
import SelectedClassWrapper from './SelectedClassWrapper'
import _ from 'lodash'
import classNames from 'classnames'

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
    showNonRegisteredClasses: state.filters.showNonRegisteredClasses,
    levelsToShow: state.filters.levels
  }
}
export class DaySchedule extends React.Component {
  static propTypes = {
    height: PropTypes.number.isRequired,
    hour: PropTypes.number.isRequired,
    day: PropTypes.number.isRequired,
    classesInTick: PropTypes.arrayOf(PropTypes.object),
    registeredClasses: PropTypes.arrayOf(PropTypes.object),
    levelsToShow: PropTypes.arrayOf(PropTypes.bool),
    hasPendingClasses: PropTypes.bool,
    showConflictedCourses: PropTypes.bool,
    showNonRegisteredClasses: PropTypes.bool
  };

  render () {
    const classesToRender = _.filter(this.props.classesInTick, (currentClass) => {
      const registered = _.any(this.props.registeredClasses, {id: currentClass.id})
      if (!registered && !this.props.showNonRegisteredClasses) { return false }
      if (registered) { return true }
      if (!this.props.levelsToShow[Math.floor(Number(currentClass.code) / 100) - 1]) { return false }
      if (this.props.showConflictedCourses) { return true }
      if (_.chain(this.props.registeredClasses).map('time').flatten().any((time) =>
        time.day === currentClass.time.day &&
        time.startMinute < currentClass.time.endMinute &&
        time.endMinute > currentClass.time.startMinute
      ).value()) { return false }
      return true
    })

    let renderedClasses = 0
    const classesEls = this.props.classesInTick.map((currentClass, i) => {
      let toRender = _.contains(classesToRender, currentClass)
      const style = {
        width: toRender ? (100 / classesToRender.length) + '%' : 0,
        left: ((100 / classesToRender.length) * renderedClasses) + '%',
        padding: toRender ? '0 5px' : 0,
        zIndex: 10 + this.props.hour
        // display: toRender ? 'block' : 'none'
      }
      if (this.props.hasPendingClasses) {
        style.marginLeft = 5
      }
      if (toRender) { renderedClasses++ }
      return (
        <div className={classNames(classes['class-container'], {[classScheduleClasses.emptyClass]: !toRender})} style={style} key={currentClass.id}>
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
    // <ReactCSSTransitionGroup transitionName='class-transition' transitionEnterTimeout={500} transitionLeaveTimeout={500}>
  // </ReactCSSTransitionGroup>
  }
}

export default connect(mapStateToProps, {})(DaySchedule)
