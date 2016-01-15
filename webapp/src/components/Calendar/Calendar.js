  import React, { PropTypes } from 'react'
  import { connect } from 'react-redux'
  import DaySchedule from 'components/DaySchedule/DaySchedule'
  import classes from './Calendar.scss'

  const mapStateToProps = (state) => ({
    classes: state.classes.content
  })
  export class Calendar extends React.Component {
    static propTypes = {
      classes: PropTypes.arrayOf(PropTypes.object)
    };

    render () {
      const days = [ 0, 1, 2, 3, 4, 5 ]

      const daysSchedule = days.map((dayNumber) =>
        <div className={classes['day-schedule']}>
          <DaySchedule
            key={'DaySchedule_' + dayNumber }
            day={dayNumber}/>
        </div>
      )

      return (
        <div className={classes['days-container']}>
          {daysSchedule}
        </div>
      )
    }
  }

  export default connect(mapStateToProps, {})(Calendar)
