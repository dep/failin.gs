class StylesheetsController < ApplicationController
  respond_to :css
  caches_page :application
end
