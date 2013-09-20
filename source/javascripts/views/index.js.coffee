class SheepTracker.Views.Index extends Thorax.View

  className: "index"
  template: SheepTracker.templates.index
  events:
    "click .add-sheep": "showForm"
    "click .attack-sheep": "attackSheep"

  initialize: ->
    @collection = new SheepTracker.Collections.Sheep()
    @collection.fetch()
    @mapView = new SheepTracker.Views.Map({@collection})
    @listView = new SheepTracker.Views.List({@collection})
    @filterBarView = new SheepTracker.Views.FilterBar({delegate: this})
    @attacked = 0

  showForm: (e) ->
    @formView = new SheepTracker.Views.Form({delegate: this})
    @formView.appendTo("body")
    return false

  attackSheep: (e) ->
    if model = @collection.at(@attacked++)
      model.set({attack: true})
    else
      @$el.addClass("attack-disabled")

  FilterBarDidChangeValue: (value) ->
    @listView.filter(value)
    @$el.toggleClass("no-map", value.length != 0)
  

view = new SheepTracker.Views.Index()
view.appendTo("body")