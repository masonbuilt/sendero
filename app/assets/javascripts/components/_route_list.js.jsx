var RouteList = React.createClass({

  handleRouteSubmit: function(route) {
    $.ajax({
      url: "/routes",
      dataType: 'json',
      type: 'POST',
      data: {route: route},
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {

    var routeListItems = this.props.data.map(function(route) {
      return (
        <RouteListItem info={route.info} key={route.id} name={route.name} id={route.id} ownerId={route.owner_id} grade={route.grade} />
      );
    });

    return (
      <div className="routeList">
        <h2>Listing routes</h2>
        <table className="routeListTable">
          <tbody>
            {routeListItems}
          </tbody>
        </table>
        <NewRouteForm onRouteSubmit={this.handleRouteSubmit} />
      </div>
    );
  }
});