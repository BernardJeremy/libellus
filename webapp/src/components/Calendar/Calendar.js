import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import DaySchedule from 'components/DaySchedule/DaySchedule'
import classes from './Calendar.scss'
import _ from 'lodash'

const reducedDaysName = [ 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' ]

const mapStateToProps = (state) => ({
  classes: state.classes.content
})
export class Calendar extends React.Component {
  static propTypes = {
    classes: PropTypes.arrayOf(PropTypes.object)
  };

  dayHasClasses = (day) => {
    return _.any(this.props.classes, (currentClass) => currentClass.time.day === reducedDaysName[day])
  };

  render () {
    const days = [ 0, 1, 2, 3, 4, 5 ]

    const daysSchedule = days.map((dayNumber) => {
      if (this.dayHasClasses(dayNumber)) {
        return <div className={classes['day-schedule']} key={dayNumber}>
          <DaySchedule day={dayNumber}/>
        </div>
      }
    })

    return (
      <div className={classes['days-container']}>
        {daysSchedule}
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(Calendar)
