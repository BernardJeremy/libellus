import List from 'material-ui/lib/lists/list'
import ListItem from 'material-ui/lib/lists/list-item'
import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import { removeFromList, selectClassId } from 'redux/modules/classes'
import classes from './ClassesList.scss'
import _ from 'lodash'
import IconButton from 'material-ui/lib/icon-button'
import FontIcon from 'material-ui/lib/font-icon'
import classNames from 'classnames'
import { hashCode } from 'utils'
import randomcolor from 'randomcolor'

const mapStateToProps = (state) => ({
  classes: state.classes.raw,
  classesList: state.classes.registeredClasses
})
export class CalendarFilter extends React.Component {
  static propTypes = {
    classes: PropTypes.arrayOf(PropTypes.object),
    classesList: PropTypes.arrayOf(PropTypes.string),
    removeFromList: PropTypes.func.isRequired,
    selectClassId: PropTypes.func.isRequired
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
        primaryText={`${currentClass.code} ${currentClass.name}`}
        leftIcon={classColorIcon}
        rightIconButton={removeClassButton}
        />)
    })

    return (
      <List subheader='Selected classes'>
        {items.length ? items : <p className={classes['no-class-selected']}>You didn't selected any class yet</p>}
      </List>
    )
  }
}

export default connect(mapStateToProps, {removeFromList, selectClassId})(CalendarFilter)
