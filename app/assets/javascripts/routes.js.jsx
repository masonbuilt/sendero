var Route = ReactRouter.Route,
      DefaultRoute = ReactRouter.DefaultRoute;

this.MyRoutes = (
  <Route handler={App}>
    <DefaultRoute handler={GradeSelect} />
    <Route handler={RouteList} path='/routez' />
    <Route handler={NewRouteForm} path='/new' />
    <Route handler={Test} path='/test' />
  </Route>
);