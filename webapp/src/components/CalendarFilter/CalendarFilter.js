import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import SelectField from 'material-ui/lib/select-field'
import MenuItem from 'material-ui/lib/menus/menu-item'
import { changeTerm, changeSubject, changeLevelVisibility, changeMinSeats } from 'redux/modules/filters'
import { load as loadTerms } from 'redux/modules/terms'
import { load as loadSubjects } from 'redux/modules/subjects'
import { load as loadClasses } from 'redux/modules/classes'
import { changeScheduleHeight } from 'redux/modules/scheduleStyle'
import classes from './CalendarFilter.scss'
import Slider from 'material-ui/lib/slider'
import Paper from 'material-ui/lib/paper'
// import classNames from 'classnames'
import ClassesList from './ClassesList/ClassesList'
import Checkbox from 'material-ui/lib/checkbox'
import _ from 'lodash'

const mapStateToProps = (state) => ({
  filters: state.filters,
  terms: state.terms.content,
  subjects: state.subjects.content,
  rowHeight: state.scheduleStyle.height,
  levels: state.filters.levels,
  minSeats: state.filters.minSeats
})
export class CalendarFilter extends React.Component {
  static propTypes = {
    filters: PropTypes.object.isRequired,
    changeTerm: PropTypes.func.isRequired,
    changeSubject: PropTypes.func.isRequired,
    loadClasses: PropTypes.func.isRequired,
    loadTerms: PropTypes.func.isRequired,
    loadSubjects: PropTypes.func.isRequired,
    changeLevelVisibility: PropTypes.func.isRequired,
    changeScheduleHeight: PropTypes.func.isRequired,
    rowHeight: PropTypes.number.isRequired,
    terms: PropTypes.arrayOf(PropTypes.object),
    levels: PropTypes.arrayOf(PropTypes.bool),
    subjects: PropTypes.arrayOf(PropTypes.object),
    minSeats: PropTypes.number,
    changeMinSeats: PropTypes.func.isRequired
  };

  componentDidMount () {
    this.props.loadTerms()
    this.props.loadSubjects()
    if (this.props.filters.termId && this.props.filters.subjectId) {
      this.props.loadClasses({subjectId: this.props.filters.subjectId, termId: this.props.filters.termId})
    }
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

  toggleLevel = (level) => {
    return () => {
      this.props.changeLevelVisibility(level, !this.props.levels[level])
    }
  };

  onChangeMinSeats = (e, value) => {
    this.props.changeMinSeats(value)
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

    const levels = _.times(6, (level) => {
      return <Checkbox
        defaultChecked={this.props.levels[level]}
        className={classes['level-switch']}
        label={(level + 1) * 100}
        onCheck={this.toggleLevel(level)}
        key={level}/>
    })

    console.log(this.props.minSeats)

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
          <Paper className={classes['level-selector-container']}>
            <p>Levels</p>
            <div className={classes['levels-container']}>
              {levels}
            </div>
          </Paper>
          <Paper className={classes['min-seats-container']}>
            <p>Minimum seats available: {String(this.props.minSeats)}</p>
            <div className={classes['min-seats-slider-container']}>
              <Slider min={0} max={30} step={1} value={this.props.minSeats} className={classes['min-seats-slider']} onChange={this.onChangeMinSeats} style={{margin: 0}}/>
            </div>
          </Paper>
          <Paper className={classes['slider-container']}>
            <p>Row Height</p>
            <Slider min={20} max={100} step={10} value={this.props.rowHeight} className={classes['row-height-selector']} onChange={this.onChangeHeight} style={{margin: 0}}/>
          </Paper>
        </div>
        <div className={classes['row']}>
          <Paper className={classes['classes-list']}>
            <ClassesList />
          </Paper>
        </div>
      </div>
    )
  }
}

export default connect(mapStateToProps, {changeTerm, changeSubject, loadTerms, loadSubjects, loadClasses, changeScheduleHeight, changeLevelVisibility, changeMinSeats})(CalendarFilter)
