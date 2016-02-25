var Route = ReactRouter.Route,
    DefaultRoute = ReactRouter.DefaultRoute;

this.MyRoutes = (
  <Route handler={App}>
    <DefaultRoute handler={Test} />
    <Route handler={RouteList} path='routez'/>
    <Route handler={Test} path='test'/>
    <Route handler={NewRouteForm} path='new'/>
  </Route>
);
