import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import SelectField from 'material-ui/lib/select-field'
import MenuItem from 'material-ui/lib/menus/menu-item'
import { changeTerm, changeSubject } from 'redux/modules/filters'
import { load as loadTerms } from 'redux/modules/terms'
import { load as loadSubjects } from 'redux/modules/subjects'
import { load as loadClasses } from 'redux/modules/classes'
import { changeScheduleHeight } from 'redux/modules/scheduleStyle'
import classes from './CalendarFilter.scss'
// import Slider from 'material-ui/lib/slider'
import Paper from 'material-ui/lib/paper'
// import classNames from 'classnames'
import ClassesList from './ClassesList/ClassesList'

const mapStateToProps = (state) => ({
  filters: state.filters,
  terms: state.terms.content,
  subjects: state.subjects.content,
  rowHeight: state.scheduleStyle.height
})
export class CalendarFilter extends React.Component {
  static propTypes = {
    filters: PropTypes.object.isRequired,
    changeTerm: PropTypes.func.isRequired,
    changeSubject: PropTypes.func.isRequired,
    loadClasses: PropTypes.func.isRequired,
    loadTerms: PropTypes.func.isRequired,
    loadSubjects: PropTypes.func.isRequired,
    changeScheduleHeight: PropTypes.func.isRequired,
    rowHeight: PropTypes.number.isRequired,
    terms: PropTypes.arrayOf(PropTypes.object),
    subjects: PropTypes.arrayOf(PropTypes.object)
  };

  componentDidMount () {
    this.props.loadTerms()
    this.props.loadSubjects()
  }

  termChanged = (event, index, value) => {
    this.props.changeTerm(value)
    this.props.loadClasses({subjectId: this.props.filters.subjectId, termId: value})
  };

  subjectChanged = (event, index, value) => {
    this.props.changeSubject(value)
    this.props.loadClasses({subjectId: value, termId: this.props.filters.termId})
  };

  onChangeHeight = (e, value) => {
    this.props.changeScheduleHeight(value)
  };

  render () {
    const terms = this.props.terms.map((term) =>
      <MenuItem
        value={term.id}
        key={term.id}
        primaryText={term.name} />
    )
    const subjects = this.props.subjects.map((subject) =>
      <MenuItem
        value={subject.id}
        key={subject.id}
        primaryText={subject.name} />
    )

    return (
      <div className={classes['container']}>
        <div className={classes['row']}>
          <Paper className={classes['filters-container']}>
            <div className={classes['filter-container']}>
              <SelectField
                value={this.props.filters.termId}
                onChange={this.termChanged}
                floatingLabelText='Term'
                fullWidth autoWidth>
                {terms}
              </SelectField>
            </div>
            <div className={classes['filter-container']}>
              <SelectField
                value={this.props.filters.subjectId}
                onChange={this.subjectChanged}
                floatingLabelText='Subject'
                fullWidth autoWidth>
                {subjects}
              </SelectField>
            </div>
          </Paper>
        </div>
        <div className={classes['row']}>
          <Paper className={classes['classes-list']}>
            <ClassesList />
          </Paper>
        </div>
      </div>
    )
  // <Paper className={classes['slider-container']}>
  //   <Slider min={20} max={100} value={this.props.rowHeight} className={classes['row-height-selector']} onChange={this.onChangeHeight} description='Row Height' />
  // </Paper>
  }
}

export default connect(mapStateToProps, {changeTerm, changeSubject, loadTerms, loadSubjects, loadClasses, changeScheduleHeight})(CalendarFilter)
