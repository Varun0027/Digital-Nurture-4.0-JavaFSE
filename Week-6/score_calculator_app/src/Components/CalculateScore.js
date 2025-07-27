import "../Stylesheets/mystyle.css";

const percentToDecimal = (decimal) => {
  return decimal.toFixed(2) + "%";
};

const calcScore = (total, goal) => {
  return percentToDecimal(total / goal);
};

export const CalculateScore = ({ Name, School, total, goal }) => (
  <div className="student-card">
    <h1 className="student-heading">Student Details</h1>

    <div className="student-name">
      <b>Name: </b>
      <span>{Name}</span>
    </div>

    <div className="student-school">
      <b>School: </b>
      <span>{School}</span>
    </div>

    <div className="student-total">
      <b>Total: </b>
      <span>{total} Marks</span>
    </div>

    <div className="student-score">
      <b>Score: </b>
      <span>{calcScore(total, goal)}</span>
    </div>
  </div>
);
