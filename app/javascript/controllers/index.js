// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Adding stimulus-confetti -- Yu
import { Confetti } from "stimulus-confetti"
application.register('confetti', Confetti)
