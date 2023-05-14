//
//  ViewController.swift
//  MusicWireframe
//
//  Created by Антон Адамсон on 11.05.2023.
//

import UIKit

class ViewController: UIViewController {

    // Отслеживание состояния кнопки проигрывания песни и наблюдатель для обновления состояния
    var isPlaying: Bool = true {
        didSet {
            playPauseButton.isSelected = isPlaying
        }
    }
    
    //MARK: - Outlets
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var reverseBackground: UIView!
    @IBOutlet var playPauseBackground: UIView!
    @IBOutlet var forwardBackground: UIView!
    @IBOutlet var reverseButton: UIButton!
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Скругляем углы и должен ли видимый слой представления ограничиваться границами представления
        /*
        reverseBackground.layer.cornerRadius = reverseBackground.frame.height / 2
        reverseBackground.clipsToBounds = true
        
        playPauseBackground.layer.cornerRadius = playPauseBackground.frame.height / 2
        playPauseBackground.clipsToBounds = true
        
        forwardBackground.layer.cornerRadius = forwardBackground.frame.height / 2
        forwardBackground.clipsToBounds = true
        */
        
        [reverseBackground, playPauseBackground, forwardBackground].forEach { view in
            view?.layer.cornerRadius = view!.frame.height / 2
            view?.clipsToBounds = true
            view?.alpha = 0.0
        }
    }
    
    // Действие при нажатии на кнопку
    @IBAction func playPauseButtonTapped() {
        // Меняем тру на фолс и наоборот
        isPlaying.toggle()
        
        // Далее действия анимации исходя из значения
        if isPlaying {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [], animations: {
                self.albumImageView.transform = CGAffineTransform.identity
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    @IBAction func touchedUpInside(_ sender: Any) {
    }
    
    // Действия после касания пальцем кнопки
    @IBAction func touchedDown(_ sender: UIButton) {
        let buttonBackground: UIView
        
        // Включения фона кнопки
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        // Анимация фона
        UIView.animate(withDuration: 0.5, animations: {
                buttonBackground.alpha = 0.0
                buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                sender.transform = CGAffineTransform.identity
            }) { (_) in
                buttonBackground.transform = CGAffineTransform.identity
            }
    }
    
}

