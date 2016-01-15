import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import _ from 'lodash'
import classes from './DaySchedule.scss'
import ScheduleTick from './ScheduleTick/ScheduleTick'
import ClassSchedule from './ClassSchedule/ClassSchedule'

const daysName = [ 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' ]
const reducedDaysName = [ 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' ]

const mapStateToProps = (state) => ({
  classes: state.classes.content
})
export class DaySchedule extends React.Component {
  static propTypes = {
    classes: PropTypes.arrayOf(PropTypes.object),
    day: PropTypes.number.isRequired
  };

  get classesScheduleOfDay () {
    return _.filter(this.props.classes, (currentClass) => currentClass.time.day === reducedDaysName[this.props.day])
  }

  render () {
    const hoursTicks = _.times(24, (hour) => <ScheduleTick hour={hour} key={hour}/>)

    const classesEls = this.classesScheduleOfDay.map((currentClass) => {
      return (<ClassSchedule data={currentClass} />)
    })

    return (
      <div className={classes['container']}>
        <p className={classes['day-title']}>{daysName[this.props.day]}</p>
        <div className={classes['scheldule-container']}>
          <div className={classes['ticks-container']}>
            {hoursTicks}
          </div>
          <div className={classes['classes-container']}>
            {classesEls}
          </div>
        </div>
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(DaySchedule)
