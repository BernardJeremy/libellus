import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import classes from './ScheduleTick.scss'
import ClassSchedule from '../ClassSchedule/ClassSchedule'
import SelectedClassWrapper from './SelectedClassWrapper'
import _ from 'lodash'

const reducedDaysName = [ 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' ]

const mapStateToProps = (state) => ({
  height: state.scheduleStyle.height,
  classes: state.classes.content
})
export class DaySchedule extends React.Component {
  static propTypes = {
    height: PropTypes.number.isRequired,
    hour: PropTypes.number.isRequired,
    day: PropTypes.number.isRequired,
    classes: PropTypes.arrayOf(PropTypes.object)
  };

  getClasses = () => {
    return _.filter(this.props.classes, (currentClass) => currentClass.time.day === reducedDaysName[this.props.day] && Number(currentClass.time.start.split(':')[0]) === this.props.hour)
  };

  hasPendingClasses = () => {
    return _.any(this.props.classes, (currentClass) => {
      return currentClass.time.day === reducedDaysName[this.props.day] &&
        Number(currentClass.time.start.split(':')[0]) < this.props.hour &&
        Number(currentClass.time.end.split(':')[0]) >= this.props.hour
    })
  };

  render () {
    const hours = [ '1:00am', '2:00am', '3:00am', '4:00am', '5:00am', '6:00am', '7:00am', '8:00am', '9:00am', '10:00am', '11:00am', '12:00am', '1:00pm', '2:00pm', '3:00pm', '4:00pm', '5:00pm', '6:00pm', '7:00pm', '8:00pm', '9:00pm', '10:00pm', '11:00pm', '12:00pm' ]

    const currentClasses = _(this.getClasses()).sortBy(this.getClasses(), 'time.duration').reverse().value()
    const classesEls = currentClasses.map((currentClass, i) => {
      const style = {
        width: (100 / currentClasses.length) + '%',
        left: ((100 / currentClasses.length) * i) + '%',
        zIndex: 10 + this.props.hour
      }
      if (this.hasPendingClasses()) {
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
