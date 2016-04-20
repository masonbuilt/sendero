var Dashboard = React.createClass({
  render: function() {
    var routeListUrl = "/users/" + this.props.currentUserId + "/routes";
    return (
      <div className="dashboard">
        <h3>Welcome, Placeholder</h3>
        <h3>My Routes</h3>
        <RouteList url={routeListUrl} pollInterval="5000" />
      </div>
    );
  }
});