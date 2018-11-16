(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UserControllerFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TUserController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUserControllerFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    UserController;

    function TUserControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var routeMiddlewares : IMiddlewareCollectionAware;
    begin
        routeMiddlewares := container.get('routeMiddlewares') as IMiddlewareCollectionAware;
        try
            result := TUserController.create(
                routeMiddlewares.getBefore(),
                routeMiddlewares.getAfter(),
                container.get('userListingView') as IView,
                container.get('viewParams') as IViewParameters,
                container.get('user.list') as IModelReader
            );
        finally
            routeMiddlewares := nil;
        end;
    end;
end.
