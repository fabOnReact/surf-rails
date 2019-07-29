import { isToday, isTomorrow } from 'date-fns'

export default class Tide {
  constructor(props) {
    this._date = new Date(props.timestamp)
    this._day = this.typeOfDay
    this._time = this.date.toLocaleTimeString()
    this._height = props.height.toPrecision(2)
    this._type = props.type
  }

  get row() { 
    return `<tr>${ this.type + this.dateAndTime + this.height }</tr>`;
  }

  get type() { return `<td>${ this._type }</td>` }
  get height() { return `<td>${ this._height }m</td>` }
  get time() { return this._time }
  get dateAndTime() { return `<td>${this.day} at ${this.time}</td>` }
  get date() { return this._date }
  get day() { return this._day }
  get typeOfDay() {
    if (isToday(this.date)) { return "Today" }
    if (isTomorrow(this.date)) { return "Tomorrow" }
  }
}
