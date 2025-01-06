# home_ui() creates the expected HTML

    Code
      home_ui("welcome")
    Output
      <div role="tabpanel" class="tab-pane" id="shiny-tab-tab_home">
        <div class="tab_container">
          <div class="tab-title">
            <div class="row">
              <div class="col-sm-6" align="left">
                <h3>Welcome</h3>
              </div>
              <div class="col-sm-6" align="right">
                <a target="_blank" href="https://rfm.rsquaredacademy.com">
                  
                  <i class="far fa-circle-question fa-2x" role="presentation" aria-label="circle-question icon"></i>
                </a>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12">
                <hr/>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="data-type-options">
              <div class="col-sm-12" align="center">
                <div id="welcome-project_type" class="form-group shiny-input-radiogroup shiny-input-container" role="radiogroup" aria-labelledby="welcome-project_type-label">
                  <label class="control-label" id="welcome-project_type-label" for="welcome-project_type">I would like to:</label>
                  <div class="shiny-options-group">
                    <div class="radio">
                      <label>
                        <input type="radio" name="welcome-project_type" value="sample" checked="checked"/>
                        <span>Explore sample data</span>
                      </label>
                    </div>
                    <div class="radio">
                      <label>
                        <input type="radio" name="welcome-project_type" value="analyze"/>
                        <span>Analyze data</span>
                      </label>
                    </div>
                    <div class="radio">
                      <label>
                        <input type="radio" name="welcome-project_type" value="new_project"/>
                        <span>Start a new project</span>
                      </label>
                    </div>
                    <div class="radio">
                      <label>
                        <input type="radio" name="welcome-project_type" value="restore_project"/>
                        <span>Open an existing project</span>
                      </label>
                    </div>
                    <div class="radio">
                      <label>
                        <input type="radio" name="welcome-project_type" value="clone_project"/>
                        <span>Clone an existing project</span>
                      </label>
                    </div>
                    <div class="radio">
                      <label>
                        <input type="radio" name="welcome-project_type" value="delete_project"/>
                        <span>Delete an existing project</span>
                      </label>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12" align="center">
              <div id="welcome-welcome_nav_btns" class="shiny-html-output"></div>
            </div>
          </div>
        </div>
      </div>

