class PetsController < ApplicationController
  before_action :set_pet, only: %i[ edit update destroy ]

  # GET /pets or /pets.json
  def index
    @pets = Pet.all
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
  end

  # POST /pets or /pets.json
  def create
    @pet = Pet.new(pet_params)
    respond_to do |format|
      if @pet.save
        format.html { redirect_to pets_url, notice: "Pet was successfully created." }
      else
        format.html { redirect_back fallback_location: root_path , notice: 'Something went wrong.' }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1 or /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to pets_url, notice: "Pet was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1 or /pets/1.json
  def destroy
    @pet.destroy!
    redirect_to pets_url, notice: "Pet was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:pet).permit(:name, :color, :pettype)
    end
end
