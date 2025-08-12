//
//  UILabelView.swift
//  UILabel
//
//  Created by 양원식 on 8/12/25.
//

import UIKit

// 패딩 라벨 (drawText/textRect 데모)
final class PaddedLabel: UILabel {
    var contentInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: contentInsets))
    }
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let r = super.textRect(forBounds: bounds.inset(by: contentInsets),
                               limitedToNumberOfLines: numberOfLines)
        return r.inset(by: UIEdgeInsets(top: -contentInsets.top,
                                        left: -contentInsets.left,
                                        bottom: -contentInsets.bottom,
                                        right: -contentInsets.right))
    }
}

// preferredMaxLayoutWidth 데모
final class WidthAwareLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        if preferredMaxLayoutWidth != bounds.width {
            preferredMaxLayoutWidth = bounds.width
        }
    }
}

final class UILabelView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 20)
        return stack
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "텍스트"
        return label
    }()
    
    private let fontLabel: UILabel = {
        let label = UILabel()
        label.text = "폰트 텍스트"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "컬러 텍스트"
        label.textColor = .green
        return label
    }()
    
    private let alignmentLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "alignmentLeft 텍스트"
        label.textAlignment = .left
        return label
    }()
    
    private let alignmentRightLabel: UILabel = {
        let label = UILabel()
        label.text = "alignmentRight 텍스트"
        label.textAlignment = .right
        return label
    }()
    
    private let alignmentJustifiedLabel: UILabel = {
        let label = UILabel()
        label.text = "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣ"
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private let alignmentNaturalLabel: UILabel = {
        let label = UILabel()
        label.text = "Natural 정렬은 텍스트의 언어 방향에 따라 자동으로 좌우 정렬을 선택합니다. 한글/영문은 보통 왼쪽 정렬로 보입니다."
        label.textAlignment = .natural
        return label
    }()
    
    private let lineBreakModeLabel: UILabel = {
        let label = UILabel()
        label.text = "가운데 말줄임표를 확인하기 위한 아주아주아주아주아주아주 길고 긴 텍스트입니다 — 중간이 … 로 잘리는지 보세요."
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingMiddle
        //    case byWordWrapping
        //    단어가 한 줄에 맞지 않는 경우를 제외하고 단어 경계에서 줄바꿈이 발생함을 나타내는 값입니다.
        //    case byCharWrapping
        //    첫 번째 문자가 맞지 않기 전에 줄바꿈이 발생함을 나타내는 값입니다.
        //    case byClipping
        //    줄이 텍스트 컨테이너의 가장자리를 넘어 확장되지 않음을 나타내는 값입니다.
        //    case byTruncatingHead
        //    줄이 컨테이너에 맞춰 표시된다는 것을 나타내는 값이며, 생략 부호는 줄의 시작 부분에서 누락된 텍스트를 나타냅니다.
        //    case byTruncatingMiddle
        //    컨테이너에 시작과 끝이 맞춰지도록 줄이 표시되고, 줄임표 문자는 가운데에 누락된 텍스트를 나타냅니다.
        return label
    }()
    
    private let notLineBreakStrategyLabel: UILabel = {
        let label = UILabel()
        label.text = "줄바꿈 전략(pushOut) 테스트용 문장입니다. 문장 말미의 구두점이나 어색한 줄바꿈을 줄이려는 전략으로, 충분히 긴 문장에서 줄바꿈 위치가 자연스러운지 비교해 보세요."
        label.numberOfLines = 0
        return label
    }()
    
    private let lineBreakStrategyLabel: UILabel = {
        let label = UILabel()
        label.text = "줄바꿈 전략(pushOut) 테스트용 문장입니다. 문장 말미의 구두점이나 어색한 줄바꿈을 줄이려는 전략으로, 충분히 긴 문장에서 줄바꿈 위치가 자연스러운지 비교해 보세요."
        label.numberOfLines = 0
        label.lineBreakStrategy = .pushOut
        return label
    }()
    
    private let isEnabledFalseLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트"
        label.isEnabled = false
        return label
    }()
    
    private let isEnabledTrueLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트"
        label.isEnabled = true
        return label
    }()
    
    private let interaction = UILargeContentViewerInteraction()
    
    private let showsExpansionTextWhenTruncatedLabel: UILabel = {
        let label = UILabel()
        label.text = "이 레이블은 showsExpansionTextWhenTruncated 동작을 확인하기 위한 매우 긴 한 줄짜리 텍스트입니다. 화면 폭보다 길어서 말줄임표가 생기면 길게 눌러 전체 텍스트를 볼 수 있어요."
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.showsExpansionTextWhenTruncated = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let adjustsFontSizeToFitWidthLabel: UILabel = {
        let label = UILabel()
        label.text = "폭에 맞춰 자동 축소 (min 70%)"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.baselineAdjustment = .alignCenters
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let allowsDefaultTighteningForTruncationLabel: UILabel = {
        let label = UILabel()
        label.text = "잘리기 전 자간 조임(티가 나도록 길게)"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 1
        label.allowsDefaultTighteningForTruncation = true
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let numberOfLinesLabel: UILabel = {
        let label = UILabel()
        label.text = "numberOfLines = 2\n세 줄 중 세 번째 줄은 보이지 않아야 합니다. 세 번째 줄입니다."
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let sizingRuleLabel: UILabel = {
        let label = UILabel()
        label.text = "ÁWJ 캡하이트(큰 글리프) 경계 계산 규칙 데모"
        if #available(iOS 17.0, *) {
            label.sizingRule = .typographic // 다른 값(.standard)과 비교하려면 교체
        }
        return label
    }()

    private let highlightedTextColorLabel: UILabel = {
        let label = UILabel()
        label.text = "하이라이트 컬러 적용"
        label.textColor = .label
        label.highlightedTextColor = .systemRed
        label.isHighlighted = true
        return label
    }()

    // Vibrancy: 블러 위에서 선명하게 보이는 라벨
    private let vibrancyContainer = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    private let vibrancyEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .systemMaterial)))
    private let preferredVibrancyLabel: UILabel = {
        let label = UILabel()
        label.text = "Vibrant Label (블러 위에서 가독성↑)"
        if #available(iOS 17.0, *) { label.preferredVibrancy = .automatic }
        return label
    }()

    private let shadowLabel: UILabel = {
        let label = UILabel()
        label.text = "그림자 있는 텍스트"
        label.shadowColor = UIColor.black.withAlphaComponent(0.25)
        label.shadowOffset = CGSize(width: 0, height: 1)
        return label
    }()


    private let paddedLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.text = "패딩 있는 라벨 (drawText/textRect)"
        label.backgroundColor = UIColor.label.withAlphaComponent(0.08)
        return label
    }()

    private let preferredMaxLayoutWidthLabel: WidthAwareLabel = {
        let label = WidthAwareLabel()
        label.text = "preferredMaxLayoutWidth를 동적으로 bounds.width에 맞춥니다. 폭이 바뀌어도 줄바꿈 계산이 안정적."
        label.numberOfLines = 0
        label.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.06)
        return label
    }()

    private let interactionEnabledLabel: UILabel = {
        let label = UILabel()
        label.text = "탭해서 텍스트 복사 (isUserInteractionEnabled = true)"
        label.isUserInteractionEnabled = true
        label.textColor = .systemBlue
        return label
    }()
    
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Public Methods
    // setBindings() 안에 추가
    @objc private func handleCopy() {
        UIPasteboard.general.string = interactionEnabledLabel.text
        print("Copied:", interactionEnabledLabel.text ?? "")
    }
}

private extension UILabelView {
    // MARK: - configure
    func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
        setBindings()
    }
    
    // MARK: - setHierarchy
    func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        [
            label,
            fontLabel,
            colorLabel,
            alignmentLeftLabel,
            alignmentRightLabel,
            alignmentJustifiedLabel,
            alignmentNaturalLabel,
            lineBreakModeLabel,
            notLineBreakStrategyLabel,
            lineBreakStrategyLabel,
            isEnabledFalseLabel,
            isEnabledTrueLabel,
            showsExpansionTextWhenTruncatedLabel,
            adjustsFontSizeToFitWidthLabel,
            allowsDefaultTighteningForTruncationLabel,
            numberOfLinesLabel,
            sizingRuleLabel,
            highlightedTextColorLabel,
            vibrancyContainer,    // 컨테이너 자체를 추가
            shadowLabel,
            paddedLabel,
            preferredMaxLayoutWidthLabel,
            interactionEnabledLabel
        ].forEach(contentStack.addArrangedSubview)
    }
    
    // MARK: - setStyles
    func setStyles() {
        backgroundColor = .gray
        
        addInteraction(interaction)
        // 콘텐츠 높이가 스크롤뷰 높이보다 작아도 위·아래로 끌었을 때 iOS 특유의 “러버밴딩(튕김)”이 항상 발생하게 하는 옵션
        scrollView.alwaysBounceVertical = true
        
        showsExpansionTextWhenTruncatedLabel.showsLargeContentViewer = true
        showsExpansionTextWhenTruncatedLabel.largeContentTitle = showsExpansionTextWhenTruncatedLabel.text
    }
    
    // MARK: - setConstraints
    func setConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 스크롤뷰를 안전영역에 꽉 채우기
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // 스택을 스크롤뷰 contentLayoutGuide에 핀
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            // 스택의 폭 = 스크롤뷰 가시 영역 폭 (가로 스크롤 방지)
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    // MARK: - setBindings
    func setBindings() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCopy))
        interactionEnabledLabel.addGestureRecognizer(tap)
    }
}
