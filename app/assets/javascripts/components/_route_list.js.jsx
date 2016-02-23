var RouteList = React.createClass({
  render: function() {

    var routeNodes = this.props.data.map(function(route) {
      return (
        <Route info={route.info} key={route.id} name={route.name} id={route.id} />
      );
    });

    return (
      <div className="routeList">
        <h2>Listing routes</h2>
        {routeNodes}
      </div>
    );
  }
});