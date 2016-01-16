import React from 'react'
import { connect } from 'react-redux'
import AppBar from 'material-ui/lib/app-bar'
// import classes from './HomeView.scss'
import CalendarFilter from 'components/CalendarFilter/CalendarFilter.js'
import Calendar from 'components/Calendar/Calendar.js'

const mapStateToProps = (state) => ({
})
export class HomeView extends React.Component {
  static propTypes = {
  };

  render () {
    return (
      <div>
        <AppBar title='Libellus for CSULB' showMenuIconButton={false} />
        <CalendarFilter/>
        <Calendar/>
      </div>
    )
  }
}

export default connect(mapStateToProps, {})(HomeView)
