(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UserListingViewFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TUserListingView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUserListingViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    CompositeView,
    UserListingView;

    function TUserListingViewFactory.build(const container : IDependencyContainer) : IView;
    var headerView : IView;
        contentView : IView;
        footerView : IView;
    begin
        headerView := TView.create(
            container.get('response') as IResponse,
            container.get('viewPartial') as IViewPartial,
            container.get('templateParser') as ITemplateParser,
            extractFileDir(getCurrentDir()) + '/app/Templates/header.html'
        );

        footerView := TView.create(
            container.get('response') as IResponse,
            container.get('viewPartial') as IViewPartial,
            container.get('templateParser') as ITemplateParser,
            extractFileDir(getCurrentDir()) + '/app/Templates/User/footer.html'
        );

        result := TCompositeView.create(
            headerView,
            TUserListingView.create(container.get('user.list') as IModelReader),
            footerView
        );
    end;
end.
