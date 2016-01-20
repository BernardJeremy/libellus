import List from 'material-ui/lib/lists/list'
import ListItem from 'material-ui/lib/lists/list-item'
import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import { removeFromList, selectClassId } from 'redux/modules/classes'
import { changeConflictedCourseVisibility, changeNonRegisteredClassVisibility } from 'redux/modules/filters'
import classes from './ClassesList.scss'
import _ from 'lodash'
import IconButton from 'material-ui/lib/icon-button'
import FontIcon from 'material-ui/lib/font-icon'
import classNames from 'classnames'
import { hashCode } from 'utils'
import randomcolor from 'randomcolor'
import Toggle from 'material-ui/lib/toggle'

const mapStateToProps = (state) => ({
  classes: state.classes.raw,
  classesList: state.classes.registeredClasses,
  showConflictedCourses: state.filters.showConflictedCourses,
  showNonRegisteredClasses: state.filters.showNonRegisteredClasses
})
export class CalendarFilter extends React.Component {
  static propTypes = {
    classes: PropTypes.arrayOf(PropTypes.object),
    classesList: PropTypes.arrayOf(PropTypes.string),
    removeFromList: PropTypes.func.isRequired,
    selectClassId: PropTypes.func.isRequired,
    changeConflictedCourseVisibility: PropTypes.func.isRequired,
    changeNonRegisteredClassVisibility: PropTypes.func.isRequired,
    showConflictedCourses: PropTypes.bool,
    showNonRegisteredClasses: PropTypes.bool
  };

  removeClass = (id) => {
    return () => {
      this.props.removeFromList(id)
      this.props.selectClassId('')
    }
  };

  selectClass = (id) => {
    return () => {
      this.props.selectClassId(id)
    }
  };

  toggleConflictedCourses = () => {
    this.props.changeConflictedCourseVisibility(!this.props.showConflictedCourses)
  };

  toggleNonRegisteredClasses = () => {
    console.log('coucou', this.props.showNonRegisteredClasses)
    this.props.changeNonRegisteredClassVisibility(!this.props.showNonRegisteredClasses)
  };

  render () {
    const items = this.props.classesList.map((id) => {
      const currentClass = _.find(this.props.classes, {id})
      if (!currentClass) { return }
      const removeClassButton = (
        <IconButton onClick={this.removeClass(id)}>
          <FontIcon className={classNames(classes['remove-class-icon'], 'fa fa-times')} />
        </IconButton>
      )
      const classColorIcon = (
        <FontIcon
          className={classNames(classes['class-color-icon'], 'fa fa-circle')}
          style={{color: randomcolor({luminosity: 'bright', seed: hashCode(currentClass.name)})}}/>
      )
      return (<ListItem
        onTouchTap={this.selectClass(id)}
        primaryText={`${currentClass.code} - ${currentClass.section} - ${currentClass.name}`}
        leftIcon={classColorIcon}
        rightIconButton={removeClassButton}
        />)
    })

    const labelStyle = {
      color: 'rgba(0, 0, 0, 0.54)',
      fontSize: 14,
      fontWeight: 500,
      lineHeight: '24px'
    }

    return (
      <div>
        <Toggle
          defaultToggled={!this.props.showNonRegisteredClasses}
          label='Only show selected classes'
          onToggle={this.toggleNonRegisteredClasses}
          labelStyle={labelStyle}
          style={{padding: '10px 16px'}}/>
        <Toggle
          defaultToggled={this.props.showConflictedCourses}
          label='Show classes in conflict'
          onToggle={this.toggleConflictedCourses}
          labelStyle={labelStyle}
          style={{padding: '10px 16px'}}
          disabled={!this.props.showNonRegisteredClasses}/>
        <List subheader='Selected classes'>
          {items.length ? items : <p className={classes['no-class-selected']}>You didn't selected any class yet</p>}
        </List>
      </div>
    )
  }
}

export default connect(mapStateToProps, {removeFromList, selectClassId, changeConflictedCourseVisibility, changeNonRegisteredClassVisibility})(CalendarFilter)
