(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your dependencies registration here---}

{-----------------------------------------------
  global view parameter
------------------------------------------------}
container.add('globalParams', TViewParametersFactory.create());

{-----------------------------------------------
  view parameters
------------------------------------------------}
container.factory('viewParams', TViewParametersFactory.create());

{-----------------------------------------------
  setup html template parser
------------------------------------------------}
container.add('templateParser', TSimpleTemplateParserFactory.create());

{-----------------------------------------------
  view partial
------------------------------------------------}
container.add(
    'viewPartial',
    TViewPartialFactory.create(
        container.get('templateParser') as ITemplateParser
    )
);
