var RouteList = React.createClass({
  render: function() {

    var routeListItems = this.props.data.map(function(route) {
    console.log(route);
      return (
        <RouteListItem info={route.info} key={route.id} name={route.name} id={route.id} ownerId={route.owner_id} grade={route.grade} />
      );
    });

    return (
      <div className="routeList">
        <h2>Listing routes</h2>
        <table className="routeListTable">
        {routeListItems}
        </table>
      </div>
    );
  }
});