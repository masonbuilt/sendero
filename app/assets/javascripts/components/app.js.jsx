var RouteHandler = ReactRouter.RouteHandler,
    Link = ReactRouter.Link;

var App = React.createClass({
  render: function() {
    return (
      <div>
        <nav>
          <ul>
            <li>
              <Link to='/new'>New Route</Link>
            </li>
            <li>
              <Link to='/test'>Test</Link>
            </li>
            <li>
              <Link to='/routez'>All Routes</Link>
            </li>
          </ul>
        </nav>
        <RouteHandler {...this.props}/>
      </div>
    );
  }
});
