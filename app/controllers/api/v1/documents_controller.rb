module Api
  module V1
    class DocumentsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_document
      def index
        @documents = Document.all
        render json: @documents
      end

      def show
        @document = Document.find(params[:id])
        render json: @document
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Document not found' }, status: :not_found
      end

      def create
        @document = Document.new(document_params)
        if @document.save
          render json: @document, status: :created
        else
          render json: { error: 'Failed to create document', message: @document.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        @document = Document.find(params[:id])
        if @document.update(document_params)
          render json: @document
        else
          render json: { error: 'Failed to update document', message: @document.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Document not found' }, status: :not_found
      end

      def destroy
        @document = Document.find(params[:id])
        if @document.destroy
          render json: { message: 'Document deleted successfully' }
        else
          render json: { error: 'Failed to delete document', message: @document.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Document not found' }, status: :not_found
      end

      def touch_document
        document = Document.find(params[:id])
        document.touch # Update the document's expiration time
        render json: document
      end

      private

      def set_document
        @document = Document.find(params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @document = nil
      end

      def document_params
        params.require(:document).permit(:name, :content)
      end
    end
  end
end
