# menu_item_home() creates expected HTML

    Code
      menu_item_home()
    Output
      <li>
        <a href="#shiny-tab-tab_home" data-toggle="tab" data-value="tab_home">
          <i class="fas fa-house sidebar-icon" role="presentation" aria-label="house icon"></i>
          <span>Home</span>
        </a>
      </li>

# menu_item_project() creates expected HTML

    Code
      menu_item_project()
    Output
      <li class="treeview">
        <a href="#shiny-tab-tab_project">
          <i class="fas fa-list-check sidebar-icon" role="presentation" aria-label="list-check icon"></i>
          <span>Project</span>
          <i class="fas fa-angle-left pull-right" role="presentation" aria-label="angle-left icon"></i>
        </a>
        <ul class="treeview-menu" style="display: none;" data-expanded="Project">
          <li>
            <a href="#shiny-tab-tab_path" data-toggle="tab" data-value="tab_path">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Retrieve
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_projects" data-toggle="tab" data-value="tab_projects">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              View
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_add_project" data-toggle="tab" data-value="tab_add_project">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Add
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_del_project" data-toggle="tab" data-value="tab_del_project">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Delete
            </a>
          </li>
        </ul>
      </li>

# menu_item_data() creates expected HTML

    Code
      menu_item_data()
    Output
      <li class="treeview">
        <a href="#shiny-tab-tab_data">
          <i class="fas fa-database sidebar-icon" role="presentation" aria-label="database icon"></i>
          <span>Data</span>
          <i class="fas fa-angle-left pull-right" role="presentation" aria-label="angle-left icon"></i>
        </a>
        <ul class="treeview-menu" style="display: none;" data-expanded="Data">
          <li>
            <a href="#shiny-tab-tab_upload" data-toggle="tab" data-value="tab_upload">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Upload
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_raw" data-toggle="tab" data-value="tab_raw">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Raw Data
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_examine" data-toggle="tab" data-value="tab_examine">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Metadata
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_project_info" data-toggle="tab" data-value="tab_project_info">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Overview
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_dashboard" data-toggle="tab" data-value="tab_dashboard">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Dashboard
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_select" data-toggle="tab" data-value="tab_select">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Select
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_transform" data-toggle="tab" data-value="tab_transform">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Transform
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_screen" data-toggle="tab" data-value="tab_screen">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Screen
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_view" data-toggle="tab" data-value="tab_view">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              View Data
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_config" data-toggle="tab" data-value="tab_config">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Configure
            </a>
          </li>
        </ul>
      </li>

# menu_item_eda() creates expected HTML

    Code
      menu_item_eda()
    Output
      <li class="treeview">
        <a href="#shiny-tab-tab_eda">
          <i class="fas fa-magnifying-glass sidebar-icon" role="presentation" aria-label="magnifying-glass icon"></i>
          <span>EDA</span>
          <i class="fas fa-angle-left pull-right" role="presentation" aria-label="angle-left icon"></i>
        </a>
        <ul class="treeview-menu" style="display: none;" data-expanded="EDA">
          <li>
            <a href="#shiny-tab-tab_orders" data-toggle="tab" data-value="tab_orders">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Orders
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_distributions" data-toggle="tab" data-value="tab_distributions">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Distributions
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_heatmap" data-toggle="tab" data-value="tab_heatmap">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Heat Map
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_bar_chart" data-toggle="tab" data-value="tab_bar_chart">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Bar Chart
            </a>
          </li>
        </ul>
      </li>

# menu_item_rfm() creates expected HTML

    Code
      menu_item_rfm()
    Output
      <li class="treeview">
        <a href="#shiny-tab-tab_rfm">
          <i class="fas fa-sitemap sidebar-icon" role="presentation" aria-label="sitemap icon"></i>
          <span>RFM</span>
          <i class="fas fa-angle-left pull-right" role="presentation" aria-label="angle-left icon"></i>
        </a>
        <ul class="treeview-menu" style="display: none;" data-expanded="RFM">
          <li>
            <a href="#shiny-tab-tab_generate_score" data-toggle="tab" data-value="tab_generate_score">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Generate Score
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_rfm_score" data-toggle="tab" data-value="tab_rfm_score">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              RFM Score
            </a>
          </li>
        </ul>
      </li>

# menu_item_segment() creates expected HTML

    Code
      menu_item_segment()
    Output
      <li class="treeview">
        <a href="#shiny-tab-tab_segmentation">
          <i class="fas fa-layer-group sidebar-icon" role="presentation" aria-label="layer-group icon"></i>
          <span>Segmentation</span>
          <i class="fas fa-angle-left pull-right" role="presentation" aria-label="angle-left icon"></i>
        </a>
        <ul class="treeview-menu" style="display: none;" data-expanded="Segmentation">
          <li>
            <a href="#shiny-tab-tab_generate_segments" data-toggle="tab" data-value="tab_generate_segments">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Generate Segments
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_segments" data-toggle="tab" data-value="tab_segments">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Segments
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_segment_summary" data-toggle="tab" data-value="tab_segment_summary">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Summary
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_segment_plot" data-toggle="tab" data-value="tab_segment_plot">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Segments Plot
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_segment_summary_plot" data-toggle="tab" data-value="tab_segment_summary_plot">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Summary Plot
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_revenue_plot" data-toggle="tab" data-value="tab_revenue_plot">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Revenue Plot
            </a>
          </li>
          <li class="treeview">
            <a href="#shiny-tab-tab_median_plot">
              <span class="sub-menu">Median Plots</span>
              <i class="fas fa-angle-left pull-right" role="presentation" aria-label="angle-left icon"></i>
            </a>
            <ul class="treeview-menu" style="display: none;" data-expanded="MedianPlots">
              <li>
                <a href="#shiny-tab-tab_median_recency" data-toggle="tab" data-value="tab_median_recency">
                  <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
                  Median Recency
                </a>
              </li>
              <li>
                <a href="#shiny-tab-tab_median_frequency" data-toggle="tab" data-value="tab_median_frequency">
                  <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
                  Median Frequency
                </a>
              </li>
              <li>
                <a href="#shiny-tab-tab_median_monetary" data-toggle="tab" data-value="tab_median_monetary">
                  <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
                  Median Monetary
                </a>
              </li>
            </ul>
          </li>
          <li>
            <a href="#shiny-tab-tab_scatter_plot" data-toggle="tab" data-value="tab_scatter_plot">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Scatter Plot
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_download" data-toggle="tab" data-value="tab_download">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Download
            </a>
          </li>
        </ul>
      </li>

# menu_item_exit() creates expected HTML

    Code
      menu_item_exit()
    Output
      <li>
        <a href="#shiny-tab-tab_exit" data-toggle="tab" data-value="tab_exit">
          <i class="fas fa-power-off sidebar-icon" role="presentation" aria-label="power-off icon"></i>
          <span>Exit</span>
        </a>
      </li>

# menu_item_help() creates expected HTML

    Code
      menu_item_help()
    Output
      <li class="treeview">
        <a href="#shiny-tab-tab_help">
          <i class="fas fa-circle-info sidebar-icon" role="presentation" aria-label="circle-info icon"></i>
          <span>Help</span>
          <i class="fas fa-angle-left pull-right" role="presentation" aria-label="angle-left icon"></i>
        </a>
        <ul class="treeview-menu" style="display: none;" data-expanded="Help">
          <li>
            <a href="#shiny-tab-tab_docs" data-toggle="tab" data-value="tab_docs">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Documentation
            </a>
          </li>
          <li>
            <a href="#shiny-tab-tab_demo" data-toggle="tab" data-value="tab_demo">
              <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
              Demo
            </a>
          </li>
        </ul>
      </li>

