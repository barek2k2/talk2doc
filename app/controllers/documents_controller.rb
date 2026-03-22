class DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    document = Document.new(document_params)
    if document.save
      redirect_to documents_path, notice: "Document created successfully."
    else
      redirect_to documents_path, alert: "Something went wrong uploading pdf."
    end

  end

  def update
    @document = Document.find(params[:id])

    title = params.require(:document).require(:title)
    content = params.require(:document).require(:content)

    DocumentUpdateService.new.update!(doc: @document, title: title, content: content)

    redirect_to @document, notice: "Document updated."
  rescue => e
    flash.now[:alert] = e.message
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy!

    redirect_to documents_path, notice: "Document deleted."
  end

  private

  def document_params
    params.require(:document).permit(:title, :content, :attachment)
  end
end