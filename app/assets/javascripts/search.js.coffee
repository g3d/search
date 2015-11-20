

Drooms.Search = class
  constructor: (@el) ->
    # Grab info from data attributes, avoid gon
    @search_uri = $(@el).data('searchUri')
    @search_button = $(@el).data('searchButton')
    @search_list = $(@el).data('searchList')
    @api_token = $(@el).data('apiToken')
    @bind_buttons()


  bind_buttons: =>
    $(@search_button).on('click', (e) =>
      e.preventDefault()
      # logic here
      @search($(@el).val())
    )

  search: (query) =>
    # Search logic
    $.ajax
        url: @search_uri
        type: "get"
        data:
          auth_token: @api_token
          'search[query]': query
        success: (data) =>
          if (data.data.length == 0)
            $(@search_list).html('<h4>No results found</h4>')
          else
            @render_list(data.data)

  render_list: (data) =>
    $(@search_list).html('')
    $(data).each (index) =>
      template = @prepare_template(data[index].attributes)
      $(@search_list).append(template)


  prepare_template: (item) =>
    # Render logic
    item_card = """
    <div class="grid-content">
      <div class="dark card search-card">
        <div class="card-divider search-card-divider">
          #{item.designed_by}
        </div>
        <div class="card-section search-card-section">
          <h4>#{item.name}</h4>
          <p>#{item.type}</p>
        </div>
      </div>
    </div>
    """
    return item_card