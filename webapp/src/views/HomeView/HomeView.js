import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import AppBar from 'material-ui/lib/app-bar'
import IconButton from 'material-ui/lib/icon-button'
import FontIcon from 'material-ui/lib/font-icon'
import AutoComplete from 'material-ui/lib/auto-complete'
import classes from './HomeView.scss'
import CalendarFilter from 'components/CalendarFilter/CalendarFilter.js'
import Calendar from 'components/Calendar/Calendar.js'
import classNames from 'classnames'
import { selectClassId } from 'redux/modules/classes'
import Colors from 'material-ui/lib/styles/colors'

const mapStateToProps = (state) => ({
  classesName: state.classes.raw.map((currentClass) => `${currentClass.code} ${currentClass.name}`),
  classes: state.classes.raw
})
export class HomeView extends React.Component {
  static propTypes = {
    classesName: PropTypes.arrayOf(PropTypes.string),
    classes: PropTypes.arrayOf(PropTypes.object),
    selectClassId: PropTypes.func.isRequired
  };

  constructor () {
    super()
    this.state = {showFilter: true}
  }

  toggleFilter = () => {
    this.setState({showFilter: !this.state.showFilter})
  };

  selectedClass = (val, index) => {
    this.props.selectClassId(this.props.classes[index].id)
  };

  render () {
    const rightMenuIcon = <div className={classes['rightMenuContainer']}>
      <AutoComplete
        dataSource={this.props.classesName}
        onNewRequest={this.selectedClass}
        filter={AutoComplete.caseInsensitiveFilter}
        style={{color: 'white'}}
        underlineFocusStyle={{borderColor: Colors.amber900}}
        hintText='Search'
        className={classes['searchInput']}/>
      <IconButton onClick={this.toggleFilter}>
        <FontIcon className={classNames(classes['showFilterIcon'], 'fa fa-chevron-up', {[classes['flipped']]: this.state.showFilter})} />
      </IconButton>
    </div>

    return (
      <div>
        <AppBar title='Libellus for CSULB' showMenuIconButton={false} iconElementRight={rightMenuIcon}/>
        <div className={classNames(classes['filterContainer'], {[classes['hidden']]: this.state.showFilter})}>
          <CalendarFilter/>
        </div>
        <Calendar/>
      </div>
    )
  }
}

export default connect(mapStateToProps, { selectClassId })(HomeView)
