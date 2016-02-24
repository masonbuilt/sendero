var RouteListItem = React.createClass({
  render: function() {
    return (
      <tr className="routeListItem">
        <td className="routeListItemName">
          <a href={"/routes/" + this.props.id}>{this.props.name} </a>
          ({this.props.grade})
        </td>
        <td className="routeListItemEdit">
          <a href={"/routes/" + this.props.id + "/edit"}>Edit</a>
        </td>
        <td className="routeListItemDestroy">
          <a href={"/routes/" + this.props.id + "/destroy"}>Destroy</a>
        </td>
      </tr>
    );
  }
});